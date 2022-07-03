// ignore_for_file: camel_case_types, override_on_non_overriding_member, no_logic_in_create_state, unused_element

import 'package:chat_app/helper.dart';
import 'package:chat_app/theme.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../models/message_data.dart';
import '../models/story_data.dart';
import '../screens/chat_screen.dart';
import '../widgets/avatar.dart';

class Message_Page extends StatelessWidget {
  const Message_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //for custom scrol view we use sliver
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegate),
        ),
      ],
    );
  }

  Widget _delegate(BuildContext context, index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTitle(
      messageData: MessageData(
        senderName: faker.person.name(),
         message: faker.lorem.sentence(),
          messageDate: date,
           dateMessage: Jiffy(date).fromNow(),
            profilePicture: Helpers.randomPictureUrl(),
            )

      );
  }
}

//for message title that contain icon name and message
class _MessageTitle extends StatelessWidget {
  const _MessageTitle({Key? key, required this.messageData}) : super(key: key);
  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(ChatScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
    
          padding: const EdgeInsets.all(4.0),
    
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.profilePicture),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical :8.0),
                      child: Text(messageData.senderName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        letterSpacing: 0.2,
                        wordSpacing: 1.5,
                        fontWeight: FontWeight.w900
                      ),
    
                      ),
                    ),
                    
                    SizedBox(
                      height: 20,
                      child: Text(messageData.message,
                         overflow: TextOverflow.ellipsis,
                         style: const TextStyle(fontSize: 12,
                         color: AppColors.textFaded
                         ),
    
                      ),
                      
                      )
                  ],
    
              )),
              
              //last seen and icon
              Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            messageData.dateMessage.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              letterSpacing: -0.2,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textFaded,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
    
                                              Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textLigth,
                                ),
                              ),
                            ),
                          )
    
                        ]
    
                      )
    
              )
    
    
    
    
            ],
          ),
        ),
      ),
    );
  }
}

//for stories
class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.only(top :8),
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
              child: Text(
                "Stories",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textFaded),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    final faker = Faker();
                    return SizedBox(
                      width: 60,
                      child: _StoryCard(
                          storyData: StoryData(
                              name: faker.person.name(),
                              url: Helpers.randomPictureUrl())),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({Key? key, required this.storyData}) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
