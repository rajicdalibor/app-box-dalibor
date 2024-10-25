import * as admin from 'firebase-admin';
import { TokenMessage } from 'firebase-admin/messaging';
import { getFirestore } from 'firebase-admin/firestore';
import * as logger from 'firebase-functions/logger';

import { Collections, User } from '@model';
import { ErrorCodes } from '@utils';

const defaultMessaging = admin.messaging();
const db = getFirestore();
const usersCollection = db.collection(Collections.users);

export type AppMessage = {
  dryRun?: boolean;
  title: string;
  titleArgs?: string[];
  subtitle?: string;
  subtitleArgs?: string[];
  body: string;
  bodyArgs?: string[];
  token: string;
  userId: string;
  data?: { [key: string]: string };
};

export type AppMessageCallable = {
  title: string;
  titleArgs?: string[];
  subtitle?: string;
  subtitleArgs?: string[];
  body: string;
  bodyArgs?: string[];
  userId: string;
  data?: { [key: string]: string };
};

/**
 * Generic push notification sender.
 * @param {AppMessage} message - The message to send as a push notification.
 * @return {Promise<string | undefined>} - The result of the notification send.
 */
export const sendPushNotificationGeneric = async (
  message: AppMessage,
): Promise<string | undefined> => {
  const {
    title,
    titleArgs,
    subtitle,
    subtitleArgs,
    body,
    bodyArgs,
    data,
    token,
    userId,
    dryRun = false,
  } = message;

  const pushNotification: TokenMessage = {
    token,
    data,
    android: {
      notification: {
        priority: 'high',
        titleLocKey: title,
        titleLocArgs: titleArgs,
        bodyLocKey: body,
        bodyLocArgs: bodyArgs,
      },
    },
    apns: {
      payload: {
        aps: {
          alert: {
            titleLocKey: title,
            titleLocArgs: titleArgs,
            subtitleLocKey: subtitle,
            subtitleLocArgs: subtitleArgs,
            locKey: body,
            locArgs: bodyArgs,
          },
          badge: 0,
          sound: {
            volume: 1,
            name: 'bingbong.aiff',
            critical: false,
          },
        },
      },
    },
  };

  try {
    return await defaultMessaging.send(pushNotification, dryRun);
  } catch (err: unknown) {
    try {
      const error = JSON.parse(JSON.stringify(err)) as {
        code: string;
        message: string;
      };
      logger.log('Error pushing notification', error, { structuredData: true });

      // Delete token for user if error code is UNREGISTERED or INVALID_ARGUMENT.
      if (
        error.code === ErrorCodes.messagingRegistrationTokenNotRegistered ||
        error.code === ErrorCodes.messagingInvalidArgument
      ) {
        // Get user ID from Firebase
        const userDoc = await usersCollection.doc(userId).get();
        const user = userDoc.data() as User;

        // Remove the invalid token from user's tokens array
        const newTokens = user.tokens?.filter(
          (existingToken: string) => existingToken !== pushNotification.token,
        );

        await usersCollection.doc(userId).update({
          tokens: newTokens,
        } as Partial<User>);
      }
    } catch (innerError: unknown) {
      const errorMessage =
        innerError instanceof Error ? innerError.message : String(innerError);
      logger.error('Error while cleaning up tokens', errorMessage, {
        structuredData: true,
      });
    }

    return;
  }
};
