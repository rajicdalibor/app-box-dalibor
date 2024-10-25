import {
  CallableRequest,
  onCall,
  onRequest,
} from 'firebase-functions/v2/https';
import { logger } from 'firebase-functions';

/**
 * Handles an HTTP request and sends a plain text response.
 *
 * @param   request   The incoming HTTP request object.
 * @param   response  The HTTP response object used to send the result back to the client.
 * @returns {void}    A Promise that resolves when the response is sent (void).
 */
export const helloWorldHttp = onRequest(async (request, response) => {
  logger.info(request);
  const apiKey = process.env.API_KEY;
  const secret = process.env.SECRET;

  logger.info(`API Key: ${apiKey}, Secret: ${secret}`);
  const responseText = await helloWorldGeneric();
  response.send(responseText);
});

/**
 * Handles a callable request from a Firebase client and returns a structured response.
 *
 * @param   request  The request object that contains data sent from the Firebase client.
 * @returns {Promise<{ responseText: string }>} A Promise that resolves to an object containing the response text.
 */
export const helloWorldCallable = onCall(
  async (request: CallableRequest): Promise<string> => {
    logger.info(request);

    // Access environment variables
    const apiKey = process.env.API_KEY;
    const secret = process.env.SECRET;

    logger.info(`API Key: ${apiKey}, Secret: ${secret}`);

    return await helloWorldGeneric();
  },
);

/**
 * Generates a "Hello World" message with the current date.
 *
 * @return {Promise<string>} A Promise that resolves to a string containing the "Hello World" message and the current date.
 */
export const helloWorldGeneric = async (): Promise<string> => {
  logger.info('Hello World logs!', { structuredData: true });
  const currentDate = new Date();
  return `Hello World, ${currentDate}`;
};
