import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article_view.dart';
import 'package:news/views/home.dart';
import '../model/Article_model.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({ required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool _loading = true;
  List<ArticleModel> article=<ArticleModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async{
     CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    article = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(
                    Icons.save,
                  ))),
        ],
        centerTitle: true ,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading?Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
