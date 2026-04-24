import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Qualita!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Your personal task manager, aka. a todo list. Click on the Tasks tab to get started, or the help icon for what you can do on this app.',
          ),
          Text('Otherwise, here are what to expect in a finished product:'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                width: 300,
                child: Card(
                  borderOnForeground: true,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.key, size: 48),
                        SizedBox(height: 8),
                        Text('Single Sign-On (SSO)'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.account_circle, size: 48),
                        SizedBox(height: 8),
                        Text('User Profiles & Customization'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.cloud_sync, size: 48),
                        SizedBox(height: 8),
                        Text('Cloud Syncing and Backup'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.flag, size: 48),
                        SizedBox(height: 8),
                        Text('Progress Visualization'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                width: 300,
                child: Card(
                  borderOnForeground: true,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.hub, size: 48),
                        SizedBox(height: 8),
                        Text('Role-Based Access Control (RBAC)'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.view_kanban, size: 48),
                        SizedBox(height: 8),
                        Text('Task Organization & Subtasks'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.chat, size: 48),
                        SizedBox(height: 8),
                        Text('In-App Messaging'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.smart_toy, size: 48),
                        SizedBox(height: 8),
                        Text('AI-Powered Insights'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
