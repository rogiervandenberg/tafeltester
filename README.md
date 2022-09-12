# Tafeltester

I wanted to play a bit with the Cubits of [flutter_bloc](https://pub.dev/packages/flutter_bloc) package ánd the teacher of my daughter said she needed a bit more practicing in multiplications, So 1 + 1 = 2 (or should I say 2 x 1 = 2 🤔😜) and here is my playful result: <https://tafeltester.web.app/>

Not fully done yet (want to give a bit more feedback with sounds and have a better way of calculating a score based on speed), but I'm quite happy with it.

If you're Dutch and are having kids that need to practice, go ahead!

This is by the way also the first time I did a web project with Flutter 😀

## Getting Started

### Development

To run locally:

Just run it: `flutter run`

### Deployment

`firebase deploy`

## About the implementation

### Available tables

To not make it too easy, the 1, 10 and 11 tables are not available by default. If you want to enable them, change the `lib/constants/tables.dart` file to add them. Furthermore the 1x... and 10x... multiplications are also not there. If you want them, add them to the for loop that generates the questions in `lib/cubit/question_cubit.dart`.

### Returning questions

If you have a correct answer, you'll get 1 point and the question will not be asked again. If you do not provide a correct answer, one point gets deducted (never below zero) and the question is re-added into the questions list.

### Local storage

To remember the settings on what tables to practice, this setting is saved into local storage. Without that you'd need to setup the app everytime when returning.

### Why in Dutch?

My daughter is not proficient yet in the English language. This app is targeted towards her and all Dutch kids that want to practice.
