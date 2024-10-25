import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/place.dart';
import 'package:intl/intl.dart';

import '../utils/date_utils.dart';

class AppUser {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? birthDate;
  final String? avatarUrl;
  final bool disabled;
  final bool? onboarded;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastKnownActivity;
  final String? installedAppVersion;
  final Place? googleAddress;

  AppUser({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.avatarUrl,
    this.disabled = false,
    this.onboarded,
    this.lastKnownActivity,
    this.installedAppVersion,
    this.googleAddress,
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      AppUserConstants.id: id,
      if (email != null) AppUserConstants.email: email,
      if (firstName != null) AppUserConstants.firstName: firstName!.trim(),
      if (lastName != null) AppUserConstants.lastName: lastName!.trim(),
      if (birthDate != null)
        AppUserConstants.birthDate: formatDateToIso(birthDate!, dateFormat),
      if (avatarUrl != null) AppUserConstants.avatarUrl: avatarUrl,
      if (onboarded != null) AppUserConstants.onboarded: onboarded,
      AppUserConstants.createdAt: createdAt.toIso8601String(),
      AppUserConstants.updatedAt: updatedAt.toIso8601String(),
      if (lastKnownActivity != null)
        AppUserConstants.lastKnownActivity:
            lastKnownActivity!.toIso8601String(),
      AppUserConstants.installedAppVersion: installedAppVersion,
      if (googleAddress != null)
        AppUserConstants.googleAddress: googleAddress!.toJson(),
    };
  }

  AppUser copyWith({
    String? firstName,
    String? lastName,
    String? birthDate,
    String? address,
    bool? onboarded,
    String? avatarUrl,
    String? phoneNumber,
    int? successfulLoops,
    DateTime? lastKnownActivity,
    String? installedAppVersion,
    Place? googleAddress,
  }) {
    return AppUser(
      id: id,
      email: email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      onboarded: onboarded ?? this.onboarded,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastKnownActivity: lastKnownActivity,
      installedAppVersion: this.installedAppVersion,
      googleAddress: googleAddress ?? this.googleAddress,
    );
  }

  static Map<String, dynamic> getDeletedUserFields() {
    return {
      AppUserConstants.firstName: AppUserConstants.deletedUserFirstName,
      AppUserConstants.lastName: AppUserConstants.deletedUserFirstName,
      AppUserConstants.birthDate: '',
      AppUserConstants.email: '',
      AppUserConstants.avatarUrl: '',
      AppUserConstants.onboarded: false,
      AppUserConstants.disabled: true,
      AppUserConstants.createdAt: DateTime.now().toIso8601String(),
      AppUserConstants.updatedAt: DateTime.now().toIso8601String(),
      AppUserConstants.googleAddress: '',
    };
  }

  static AppUser? fromJson(DocumentSnapshot snapshot) {
    try {
      if (snapshot.data() == null) {
        return null;
      }
      final data = snapshot.data() as Map<String, dynamic>;

      String? birthDate;
      if (data[AppUserConstants.birthDate] != null) {
        DateTime parsedBirthDate =
            DateTime.parse(data[AppUserConstants.birthDate]);
        birthDate = DateFormat(dateFormat).format(parsedBirthDate);
      }

      return AppUser(
        id: data[AppUserConstants.id],
        email: data[AppUserConstants.email],
        firstName: data[AppUserConstants.firstName],
        lastName: data[AppUserConstants.lastName],
        birthDate: birthDate,
        onboarded: data[AppUserConstants.onboarded],
        avatarUrl: data[AppUserConstants.avatarUrl],
        lastKnownActivity: data[AppUserConstants.lastKnownActivity]?.toDate(),
        installedAppVersion: data[AppUserConstants.installedAppVersion],
        googleAddress: data[AppUserConstants.googleAddress] != null
            ? Place.fromSnapshot(data[AppUserConstants.googleAddress])
            : null,
      );
    } catch (e) {
      debugPrint("Error mapping AppUser from snapshot: $e");
      return null;
    }
  }

  String displayName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

class AppUserConstants {
  static const String id = 'id';
  static const String kids = 'kids';
  static const String email = 'email';
  static const String name = 'name';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String birthDate = 'birthDate';
  static const String address = 'address';
  static const String phoneNumber = 'phoneNumber';
  static const String avatarUrl = 'avatarUrl';
  static const String onboarded = 'onboarded';
  static const String updatedAt = 'updatedAt';
  static const String deletedUserFirstName = 'unknown-user';
  static const String createdAt = 'createdAt';
  static const String tokens = 'tokens';
  static const String disabled = 'disabled';
  static const String lastKnownActivity = 'lastKnownActivity';
  static const String installedAppVersion = 'installedAppVersion';
  static const String googleAddress = 'googleAddress';
}
