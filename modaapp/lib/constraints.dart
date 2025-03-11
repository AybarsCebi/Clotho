import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class Constraints {
  List<String> usernames=['Ivanakerr', 'LunaFrost', 'ScarlettJazz','MaxEverest', 
  'Ameliablaze', 'Oliverphoenix', 'IsabellaWren', 'MasonOnyx', 'Avaspectre', 'BenjaminAether'];
  
}

class AddPic {
  File? image;
  Future pickImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  Future pickImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }
  
  void setState(Null Function() param0) {}
}

class welcomequotes {
  List<String> quotes=[
  '''"Fashion is the armor to survive the reality of everyday life."\n- Bill Cunningham''',
  '''"Fashion has to reflect who you are, what you feel at the moment, and where you're going."\n- Pharrell Williams''',
  '''"Style is a way to say who you are without having to speak."\n - Rachel Zoe''',
  '''"Fashion is about something that comes from within you."\n - Ralph Lauren''',
  '''"Clothes mean nothing until someone lives in them."\n - Marc Jacobs''',
  '''"Fashion is about dreaming and making other people dream."\n - Donatella Versace''',
  '''"Fashion is the most powerful art there is. It's movement, design, and architecture all in one."\n - Alexander McQueen''',
  '''"Fashion is about confidence. If you feel great in an outfit, it shows."\n - Mireille Guiliano''',
  '''"The best things in life are free. The second best are very expensive."\n - Coco Chanel''',
  '''"Fashion is not necessarily about labels. It's not about brands. It's about something else that comes from within you."\n - Ralph Lauren''',
  '''"Fashion is instant language."\n - Miuccia Prada''',
  '''"Elegance is not about being noticed, it's about being remembered."\n - Giorgio Armani''',
  '''"Simplicity is the keynote of all true elegance."\n - Coco Chanel''',
  '''"Fashion should be a form of escapism and not a form of imprisonment."\n - Alexander McQueen''',
  '''"I like my money right where I can see it: hanging in my closet."\n - Carrie Bradshaw''',
  '''"Fashion is about dressing according to what’s fashionable. Style is more about being yourself."\n - Oscar de la Renta''',
  '''"Fashion is about good energy. It's about feelings. That's what I have to give the people, good energy and good feelings."\n - Adriana Lima''',
  '''"Style is knowing who you are, what you want to say, and not giving a damn."\n - Gore Vidal''',
  '''"Fashion should never be comfortable. You feel cozy in your home. To be fashionable, you need discomfort."\n - Donatella Versace''',
  '''"You can never take too much care over the choice of your shoes. Too many women think that they are unimportant, but the real proof of an elegant woman is what is on her feet."\n - Christian Dior'''
  ];
}

class Blog {
  String author, date, title, detail;
  int read;
  Blog(this.author, this.date, this.title, this.detail, this.read);
}

class bloginfo{
  List<String> authors =["WhisperingWillow","AlexEthereal","OliviaWanderlust","SebastianVoyage", 
  "SophiaSerenity", "LiamNomadic", "IsabellaEnchant", "NoahJourneyman", "AmeliaWanderer", "GabrielRoam"];
  List<String> dates=["January 15, 2023", "March 7, 2023", "April 22, 2023", "May 12, 2023", "June 28, 2023",
  "August 9, 2023", "September 17, 2023", "October 5, 2023", "November 20, 2023", "December 8, 2023"];
  List<String> titles=["Summer Fashion Trends: Embrace the Sun in Style", "Eco-Friendly Fashion: Sustainable Choices for a Greener Wardrobe",
  "Classic vs. Contemporary: A Timeless Fashion Dilemma", "Accessorize Like a Pro: Elevate Your Outfit with the Right Details",
  "Revamping Your Closet: Mixing and Matching for a Fresh Look", "The Power of Denim: A Staple in Every Fashionista's Closet",
  "Chic and Comfy: Finding the Perfect Balance in Athleisure", "Haute Couture Unveiled: Exploring High Fashion’s Fascinating World",
  "Effortless Elegance: Mastering the Art of Casual Chic", "The Evolution of Style: Trends That Shaped Fashion in 2023"];
  List<int> reads=[160,251,97,583,211,197,674,392,976,112];
  List<String> details=[
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''Vintage fashion never loses its charm. Each piece carries a story, a sense of nostalgia. From the roaring '20s to the free-spirited '70s, vintage styles have left an indelible mark. The elegance of bygone eras is now revamped, integrated into modern trends. Embrace the allure of vintage; it's a timeless journey through fashion history.''',
    '''Athleisure, the epitome of fashion meeting function, is redefining modern style. It seamlessly blends activewear with everyday fashion, offering comfort without compromising on trendiness. Whether gym-bound or hitting the streets, athleisure adapts, ensuring you stay chic and comfortable. It's more than a trend—it's a lifestyle.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.''',
    '''In a world of trends, embracing timeless style is a statement. Classic pieces like a crisp white shirt, tailored trousers, or a little black dress never go out of fashion. Investing in quality, versatile items ensures a wardrobe that withstands fleeting trends. It's about expressing individuality through staple pieces that define your unique fashion journey. Finding what suits you and exudes confidence is the key. Fashion is personal, a blend of trends and personal taste, allowing you to curate a signature style that represents you, transcending seasons and leaving a lasting sartorial impression.'''
];
}

class podcastinfo{
  List<String> voices=["EthanClarke", "OliviaMartinez", "LucasThompson", "AvaAnderson"];
  List<String> dates=["September 17, 2023", "November 20, 2023", "October 5, 2023", "March 7, 2023"];
  List<String> titles=["Fashion Forward: Trends and Styles", "The Chic Chat: A Fashion Podcast", "Haute Talk: Exploring Fashion's World", "Couture Conversations: Unveiling Style Stories"];
  List<int> listens=[512, 171, 934, 399];
  List<String> details=[
  "A guiding podcast to discover current fashion trends and styles",
  "Elegant conversations and delightful discussions about the latest happenings in the fashion world.",
  " In-depth conversations uncovering the fashion world, filled with interesting stories.",
  "A podcast delving into the world of fashion, featuring discussions and inspiring conversations about the story of style."];
}

class Saves{
  String name="aaaa";
  Saves(this.name);
}

Color darkcolor=Color.fromARGB(255, 42, 42, 42);
Color bckgrd = Color.fromARGB(255, 235, 235, 235);

  String blank_profile_url ="https://firebasestorage.googleapis.com/v0/b/clotho-67236.appspot.com/o/images%2Fblank_profile_pic.jpg?alt=media&token=3bd92464-852d-47a1-8887-74331412bfff";
