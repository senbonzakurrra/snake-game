import 'package:flutter/material.dart';


class AppImages {
  // Приватный констуктор - нельзя создать экземпляр этого класса
  AppImages._();

  // Путь к картинкам
  static const String snake = 'assets/images/snake.jpg';
  static const String logo = 'assets/images/logo.jpg';

  // Метод для быстрого получения виджета с изображением змейки 
 static Widget snakeImages({
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
 }) {
  return  Image.asset(
    'assets/images/snake.jpg',
    width: width,
    height: height,
    fit: fit,
  );
 }

 // Метод для логотипа 
 static   Widget logoImage({
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
 }) {
  return  Image.asset(
    'assets/images/logo.jpg',
    width: width,
    height: height,
    fit: fit,
  );
 }

 // Запасной виджет если изображение не загрузилось
 // ignore: unused_element
 static Widget _buildScoreWidget(double? width, double? height) {
  return Container(
    width: width,
    height: height,
    color: Colors.grey,
    child: const Center(
      child: Icon(Icons.image_not_supported, color: Colors.white),
    ),
  );
 }  

 // Для использования в BoxDecoration в других местах
 static AssetImage get snakeAsset => AssetImage(snake);
 static AssetImage get logoAsset => AssetImage(logo); 
}