import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../modules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onFieldSubmitted,
  Function(String)? onChange,
  VoidCallback? onTap,
  VoidCallback? suffixPressed,
  String? Function(String?)? validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
}) =>
    TextFormField(
      // style: const TextStyle(
      //   fontSize: 25.0,
      // ),
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      validator: validate,
      obscureText: isPassword,
      onTap: onTap,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        border: const OutlineInputBorder(),
        suffix: IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffixIcon),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: article['urlToImage'] != null
                      ? NetworkImage('${article['urlToImage']}')
                      : const NetworkImage(
                          'https://www.lincolnsquarebid.org/uploads/NewsModel/1105/image/community-alert-image.detailPage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

void navigateTo(BuildContext context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );

PreferredSizeWidget buildDefaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? action,
}) =>
    AppBar(
      title: Text(
        title!,
        style: const TextStyle(color: Colors.grey),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.grey,
        ),
      ),
      actions: action,
    );
