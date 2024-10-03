import 'package:flutter/material.dart';
import 'package:fundriser/model/content_data_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    ContentDataModel data = ModalRoute.of(context)!.settings.arguments as ContentDataModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Content"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                data.imageLink ?? "",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              data.title ?? "",
              style: grayTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset('assets/ic_person_placeholder.png', width:20, height: 20,),
                const SizedBox(width: 10),
                Text("admin", style: thinGrayTextStyle.copyWith(
                  fontSize: 12
                ),)
              ],
            ),
            const SizedBox(height: 10),
              Text(
                stringToDate(data.createdAt.toString()),
                style: grayTextStyle.copyWith(
                  fontSize: 10
                ),
              ),
            const SizedBox(height: 20),
            Text(
              data.content ?? "",
              style: grayTextStyle.copyWith(
                fontSize: 14
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

          ],
        ),
      )
    );
  }
}