import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/views/article_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();

  }

  getNews() async{
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black87)),
            Text("News",style: TextStyle( fontWeight: FontWeight.bold , color: Colors.black87)) ,
            //style: TextStyle(color: Colors.blue),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:_loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget> [
              SizedBox(
                height: 70,
                  child: ListView.builder(itemCount:categories.length, scrollDirection: Axis.horizontal, shrinkWrap: true, itemBuilder: (context,index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount:articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context,index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
              }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  const CategoryTile({super.key, this.imageUrl, this.categoryName });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => category(
        //       newsCategory: categoryName.toLowerCase(),
        //     )
        // ));
      },
      child: Container(
        margin: const EdgeInsets.only(right:16),
        child: Stack(
          children: <Widget>[
            ClipRRect( borderRadius:BorderRadius.circular(6), child: CachedNetworkImage(imageUrl: imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child: Text(categoryName,style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc,url ;
  const BlogTile({super.key, required this.imageUrl,required this.title , required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
                blogUrl:url,
            )
        ));
      },
      // onTap: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl:url))
      // },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(borderRadius:BorderRadius.circular(6), child: Image.network(imageUrl)),
            const SizedBox(height: 8,),
            Text(title, style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),),
            const SizedBox(height: 8,),
            Text(desc, style:const TextStyle(
              color: Colors.grey
            ))
          ],
        ),
      ),
    );
  }
}
