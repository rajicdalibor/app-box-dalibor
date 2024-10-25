import {
  CallableRequest,
  onCall,
  onRequest,
} from 'firebase-functions/v2/https';
import {
  ErrorMessage,
  sendPushNotificationGeneric,
  AppMessageCallable,
} from '@utils';
import { logger } from 'firebase-functions/v2';
import { getFirestore } from 'firebase-admin/firestore';
import { Collections, UserFieldConstants } from '@model';

const db = getFirestore();
const usersCollection = db.collection(Collections.users);

export const sendPushNotificationHttps = onRequest(
  async (request, response) => {
    try {
      const dryRun: boolean = request.body.dryRun
        ? request.body.dryRun === 'true'
        : false;

      const {
        title,
        titleArgs,
        subtitle,
        subtitleArgs,
        body,
        bodyArgs,
        token,
        userId,
        data,
      }: {
        title: string;
        titleArgs?: string[];
        subtitle?: string;
        subtitleArgs?: string[];
        body: string;
        bodyArgs?: string[];
        token: string;
        userId: string;
        data?: { [key: string]: string };
      } = request.body;

      const res = await sendPushNotificationGeneric({
        title,
        titleArgs,
        subtitle,
        subtitleArgs,
        body,
        bodyArgs,
        data,
        token,
        userId,
        dryRun,
      });

      response.status(200).send(res);
    } catch (error: unknown) {
      const errorMessage = (error instanceof Error
        ? error.message
        : String(error)) as unknown as ErrorMessage;
      response.status(500).send(`Internal Server Error: ${errorMessage}`);
    }
  },
);

export const sendPushNotificationCallable = onCall(
  async (request: CallableRequest<AppMessageCallable>) => {
    try {
      const {
        title,
        titleArgs,
        subtitle,
        subtitleArgs,
        body,
        bodyArgs,
        data,
        userId,
      } = request.data;

      const user = usersCollection.doc(userId);
      const userSnapshot = await user.get();
      const tokens: string[] =
        userSnapshot.get(UserFieldConstants.tokens) ?? [];

      for (const token of tokens) {
        const res = await sendPushNotificationGeneric({
          title,
          titleArgs,
          subtitle,
          subtitleArgs,
          body,
          bodyArgs,
          data,
          token,
          userId,
        });
        logger.info('Message sent', res);
      }
    } catch (error: unknown) {
      logger.error(
        'Error:',
        error instanceof Error ? error.message : String(error),
      );
    }
  },
);
