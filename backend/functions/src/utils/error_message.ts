export type ErrorMessage = {
  structuredData: boolean;
  severity: 'INFO' | 'ERROR';
  error: { code: string; message: string };
};
