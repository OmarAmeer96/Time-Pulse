// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Forget Password !`
  String get forget_password {
    return Intl.message(
      'Forget Password !',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your email`
  String get enter_your_email {
    return Intl.message(
      'Please, enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your password`
  String get enter_your_password {
    return Intl.message(
      'Please, enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Email is not valid ,please enter a valid email`
  String get valid_email {
    return Intl.message(
      'Email is not valid ,please enter a valid email',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 chars`
  String get password_length {
    return Intl.message(
      'Password must be at least 6 chars',
      name: 'password_length',
      desc: '',
      args: [],
    );
  }

  /// `The supplied auth credential is incorrect, malformed or has expired.`
  String get incorrect_email_or_password {
    return Intl.message(
      'The supplied auth credential is incorrect, malformed or has expired.',
      name: 'incorrect_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent!`
  String get reset_password {
    return Intl.message(
      'Password reset email sent!',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Empty History`
  String get empty_history {
    return Intl.message(
      'Empty History',
      name: 'empty_history',
      desc: '',
      args: [],
    );
  }

  /// `Check-in time`
  String get check_in {
    return Intl.message('Check-in time', name: 'check_in', desc: '', args: []);
  }

  /// `Check-out time`
  String get check_out {
    return Intl.message(
      'Check-out time',
      name: 'check_out',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message('Reason', name: 'reason', desc: '', args: []);
  }

  /// `End Date`
  String get end_date {
    return Intl.message('End Date', name: 'end_date', desc: '', args: []);
  }

  /// `Start Date`
  String get start_date {
    return Intl.message('Start Date', name: 'start_date', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `No vacations till now`
  String get no_vacation {
    return Intl.message(
      'No vacations till now',
      name: 'no_vacation',
      desc: '',
      args: [],
    );
  }

  /// `Vacations`
  String get vacations {
    return Intl.message('Vacations', name: 'vacations', desc: '', args: []);
  }

  /// `Request Vacation`
  String get request_vacation {
    return Intl.message(
      'Request Vacation',
      name: 'request_vacation',
      desc: '',
      args: [],
    );
  }

  /// `Please select a start date`
  String get select_a_start_date {
    return Intl.message(
      'Please select a start date',
      name: 'select_a_start_date',
      desc: '',
      args: [],
    );
  }

  /// `Please select an end date`
  String get select_a_end_date {
    return Intl.message(
      'Please select an end date',
      name: 'select_a_end_date',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a reason for your request`
  String get select_a_reason {
    return Intl.message(
      'Please enter a reason for your request',
      name: 'select_a_reason',
      desc: '',
      args: [],
    );
  }

  /// `Request submitted successfully`
  String get request_submitted {
    return Intl.message(
      'Request submitted successfully',
      name: 'request_submitted',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, Your remaining balance is not enough`
  String get remaining_balance {
    return Intl.message(
      'Sorry, Your remaining balance is not enough',
      name: 'remaining_balance',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `HomePage`
  String get home_page {
    return Intl.message('HomePage', name: 'home_page', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome {
    return Intl.message('Welcome Back', name: 'welcome', desc: '', args: []);
  }

  /// `Please click here to check out`
  String get click_to_check_out {
    return Intl.message(
      'Please click here to check out',
      name: 'click_to_check_out',
      desc: '',
      args: [],
    );
  }

  /// `Please click here to check in`
  String get click_to_check_in {
    return Intl.message(
      'Please click here to check in',
      name: 'click_to_check_in',
      desc: '',
      args: [],
    );
  }

  /// `Checked in successfully`
  String get checked_in {
    return Intl.message(
      'Checked in successfully',
      name: 'checked_in',
      desc: '',
      args: [],
    );
  }

  /// `Checked out successfully`
  String get checked_out {
    return Intl.message(
      'Checked out successfully',
      name: 'checked_out',
      desc: '',
      args: [],
    );
  }

  /// `You are out of company area`
  String get out_of_company {
    return Intl.message(
      'You are out of company area',
      name: 'out_of_company',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Dark Mode`
  String get dark {
    return Intl.message('Dark Mode', name: 'dark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Leaves`
  String get leaves {
    return Intl.message('Leaves', name: 'leaves', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `No name provided`
  String get no_name_provided {
    return Intl.message(
      'No name provided',
      name: 'no_name_provided',
      desc: '',
      args: [],
    );
  }

  /// `Employee ID`
  String get employee_id {
    return Intl.message('Employee ID', name: 'employee_id', desc: '', args: []);
  }

  /// `Position`
  String get position {
    return Intl.message('Position', name: 'position', desc: '', args: []);
  }

  /// `Department`
  String get department {
    return Intl.message('Department', name: 'department', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Not Specified`
  String get not_specified {
    return Intl.message(
      'Not Specified',
      name: 'not_specified',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Employees Data`
  String get employee_data {
    return Intl.message(
      'Employees Data',
      name: 'employee_data',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Accepted`
  String get accepted {
    return Intl.message('Accepted', name: 'accepted', desc: '', args: []);
  }

  /// `Employee History`
  String get employee_history {
    return Intl.message(
      'Employee History',
      name: 'employee_history',
      desc: '',
      args: [],
    );
  }

  /// `Add Employee`
  String get add_employee {
    return Intl.message(
      'Add Employee',
      name: 'add_employee',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Account Created Successfully`
  String get account_created {
    return Intl.message(
      'Account Created Successfully',
      name: 'account_created',
      desc: '',
      args: [],
    );
  }

  /// `Please enter employee name`
  String get enter_employee_name {
    return Intl.message(
      'Please enter employee name',
      name: 'enter_employee_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid employee name`
  String get valid_name {
    return Intl.message(
      'Please enter valid employee name',
      name: 'valid_name',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Admin must use admin tab`
  String get admin_must_use_admin_tab {
    return Intl.message(
      'Admin must use admin tab',
      name: 'admin_must_use_admin_tab',
      desc: '',
      args: [],
    );
  }

  /// `Users cannot log in using the admin tab. Please use the user tab.`
  String get user_must_use_user_tab {
    return Intl.message(
      'Users cannot log in using the admin tab. Please use the user tab.',
      name: 'user_must_use_user_tab',
      desc: '',
      args: [],
    );
  }

  /// `Vacation Balance`
  String get vacation_balance {
    return Intl.message(
      'Vacation Balance',
      name: 'vacation_balance',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
