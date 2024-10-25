import { DocumentData } from 'firebase-admin/lib/firestore';

export interface User extends DocumentData {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  birthDate: string;
  avatarUrl: string;
  disabled: boolean;
  onboarded: boolean;
  createdAt: Date;
  updatedAt: Date;
  lastKnownActivity: Date;
  installedAppVersion: string;
}

export const UserFieldConstants = {
  id: 'id',
  email: 'email',
  name: 'name',
  firstName: 'firstName',
  lastName: 'lastName',
  birthDate: 'birthDate',
  avatarUrl: 'avatarUrl',
  disabled: 'disabled',
  onboarded: 'onboarded',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  lastKnownActivity: 'lastKnownActivity',
  installedAppVersion: 'installedAppVersion',
  tokens: 'tokens',
};
