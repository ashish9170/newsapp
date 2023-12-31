import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/views/article_view.dart';
import 'package:news/views/category_news.dart';
import '../helper/news.dart';
import '../model/Article_model.dart';
import '../model/category_model.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
List<ArticleModel> article = <ArticleModel>[];
bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }
  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    article = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text("News",style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:loading?Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(

                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),

              ///blogtile
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: article.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return blogTile(
                      imageUrl: article[index].urlToImage,
                      title: article[index].title,
                      desc: article[index].description,
                     url: article[index].url,
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl;
  final categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
  Navigator.push(context, MaterialPageRoute(builder:( context)=> CategoryNews(
    category: categoryName.toString().toLowerCase(),)
  ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrl, width: 120, height: 60, fit: BoxFit.cover, ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      // Add your onTap or other gesture handling code here if needed
    );
  }
}

class blogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  blogTile({required this.imageUrl, required this.title, required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=>ArticleView(
            blogUrl:url,
            )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),

            SizedBox(height: 8,),
            Text(title ,style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
                fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 8,),
            Text(desc ,style: TextStyle(
              color: Colors.black54
            ),),
          ],
        ),
      ),
    );
  }
}

