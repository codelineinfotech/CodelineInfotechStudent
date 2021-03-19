import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth kFirebaseAuth = FirebaseAuth.instance;
FirebaseFirestore kFireStore = FirebaseFirestore.instance;


CollectionReference cAdminLangCollection = kFireStore.collection('AdminLang');
CollectionReference cUserCollection = kFireStore.collection('User');
CollectionReference cAdminCollection = kFireStore.collection('Admin');
CollectionReference cDataCollection = kFireStore.collection('Data');
CollectionReference cContactUsCollection = kFireStore.collection('ContactUs');
CollectionReference cAssignmentSubmissionCollection = kFireStore.collection('AssignmentSubmission');
CollectionReference cCourseCompletedTopicCollection = kFireStore.collection('CourseCompletedTopic');
CollectionReference cNotificationCollection = kFireStore.collection('Notification');
CollectionReference cTopicsCollection =
kFireStore.collection('Topics');