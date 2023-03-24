import 'package:keyboard_dismisser/keyboard_dismisser.dart';

const List<GestureType> kDismissKeyboardGestures = [
  GestureType.onTap,
  GestureType.onPanUpdateDownDirection,
];

const String kLogoPath = 'assets/images/logo.png';
const String kGoogleLogoPath = 'assets/images/google.png';
const String kLoginEmotePath = 'assets/images/loginEmote.png';

const String kBannerDefault =
    'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
const String kAvatarDefault =
    'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';
const String kNotFoundDefault =
    'https://img.freepik.com/premium-vector/flat-404-error-template_23-2147753090.jpg?w=1380';

// failure messages
const String kNetworkFailureMsg =
    "We're having trouble connecting to the internet. Please check your connection and try again.";
const String kServerFailureMsg =
    'Oops! Something went wrong on our end. Please try again later or contact customer support if the problem persists.';
const String kUnexpectedFailureMsg =
    "Oops! Something went wrong on our end. Our team has been notified and we're working to fix the issue as soon as possible. In the meantime, please try again later or contact customer support for further assistance.";
const String kCommunityNameAlreadyExistFailureMsg =
    'Community name already exist.';
const String kCorruptedImageFailureMsg =
    'The image file you\'re trying to open is invalid or damaged. Please check the file and try again.';
const String kNotFoundFailureMsg = 'Resource not found.';

// default messages
const String kDefaultErrorMsg = 'Error: Something went wrong';
const String kDefaultNotFoundMsg = '404: Not found.';
const String kDefaultEmptyMsg = 'Nothing to see here.';

// platform exception codes
const String kInvalidImage = 'invalid_image';
