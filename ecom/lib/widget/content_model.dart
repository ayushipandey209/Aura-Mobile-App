class UnBoardingContent {
  String image;
  String title;
  String description;

  UnBoardingContent({
        required this.image ,
         required this.title ,
         required this.description ,
  });


}
List <UnBoardingContent> contents=[
  UnBoardingContent(image: 'images/screen1.jpeg', title: 'Variety that suits you', description:'Pick Your Favourite choice \n 25000+ customers'),
  UnBoardingContent(image: 'images/screen2.png', title: 'Card payment is easy ', description:'Have your Digital Wallet \n Safe and Secure'),
  UnBoardingContent(image: 'images/screen3.png', title: 'Fastest Delivery', description:'All across India ')


];