/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import * as admin from 'firebase-admin';
import { setGlobalOptions } from 'firebase-functions/v2';

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

admin.initializeApp();

setGlobalOptions({ region: 'europe-west6' });

export { helloWorldHttp, helloWorldCallable } from '@helloWorld';
export {
  sendPushNotificationCallable,
  sendPushNotificationHttps,
} from '@messaging';
