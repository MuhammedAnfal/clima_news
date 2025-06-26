Flutter app that includes weather and news features with animations and pagination.
Animated UI Components
Login/Signup Screens:

Tween animations with fade-in effects for form sections

Sequential element transitions

Home Screen:

Expanding search field animation (small → large)

Weather data slide-up transition

Shimmer loading effects for empty states

Weather Functionality
Current weather display with temperature and conditions

Paginated Hourly Forecast:

4-hour increments displayed per page

Horizontal swipe navigation

Weather condition icons

Location search with dynamic updates

Profile icon navigation

News Functionality
Dual News Sections:

Trending News

Personalized "News for You"

Searchable news database

Paginated Loading:

10 items per batch

Infinite scroll implementation

Search history persistence

User Experience
3-screen onboarding sequence

Profile screen with user details (name, email)

Responsive bottom navigation

Setup Instructions <a name="setup-instructions"></a>
Prerequisites
Flutter SDK (v3.13.0+)

Dart (v3.1.0+)

Android Studio / VS Code

Physical device or emulator

Installation Steps
bash
# Clone repository
git clone https://github.com/<your-username>/weather-news-app.git
cd weather-news-app

# Install dependencies
flutter pub get

# Create environment file
cp .env.example .env

# Add API keys to .env file
echo "OPENWEATHER_API_KEY=your_api_key_here" >> .env
echo "NEWSAPI_KEY=your_api_key_here" >> .env

# Run the application
flutter run
Deployment Guide <a name="deployment-guide"></a>
Android Build
bash
# Build release APK
flutter build apk --release --target-platform android-arm64

# Output location
build/app/outputs/apk/release/app-release.apk
iOS Build
bash
# Build iOS project
flutter build ios --release

# Open in Xcode
open ios/Runner.xcworkspace
In Xcode:

Select Product > Archive

Follow distribution wizard

Export IPA file

Web Deployment
bash
flutter build web
# Deploy contents of build/web folder
Testing Instructions <a name="testing-instructions"></a>
Animation Verification
Screen	Animation Test	Expected Result
Login/Signup	Form elements appear	Sequential fade-in (500ms)
Home Screen	Initial load	Search field expands smoothly
Weather data load	Elements slide up from bottom
Empty data state	Shimmer loading appears
Weather Functionality Tests
Location Search:

Enter "London" → Verify weather updates within 3s

Enter invalid location → Verify error message

Clear search → Verify reverts to current location

Hourly Forecast:

Swipe right → Next 4-hour segment appears

Swipe left → Previous segment appears

Verify each segment shows:

Time range (e.g., 09:00-12:59)

Temperature value

Weather condition icon

News Functionality Tests
Search & Pagination:

Search "Technology" → Verify 10 results

Scroll to bottom → Verify next 10 load

Clear search → Verify default news returns

Test search persistence after app restart

Content Sections:

Verify "Trending News" appears

Verify "News for You" is personalized

Check image/text rendering quality

Profile & Navigation
Verify profile displays correct:

User name

Email address

Test bottom navigation:

weather → News → Profile → 

Verify onboarding appears only on first launch


.env file configuration:

env
#OpenWeatherMap API
OPENWEATHER_API_KEY='2dbeacab2f1a472c8f1c55ede25218db'

#NewsAPI Configuration
NEWSAPI_KEY='143a33ea0cc641b1a32c7a1a3e8dd652'
Animation Parameters
Animation	Duration	Curve	Target Elements
LoginFormFadeIn	500ms	easeInOut	Email/Password fields
SearchFieldExpand	300ms	easeInBack	Home screen search bar
WeatherDataSlideUp	400ms	easeOutCubic	Temperature/condition display
ShimmerLoading	1000ms	linear	All data placeholders
API Endpoints
dart

// Weather Service
const weatherUrl = "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=$weatherApiKey&units=metric&exclude=minutely";

// News Service
const newsUrl = "https://newsapi.org/v2/everything?q=technology&pageSize=10&apiKey=$newsApiKey";


Key Files

lib/screens/home/home_screen.dart - Main weather dashboard

lib/widgets/hourly_forecast.dart - Paginated forecast widget

lib/screens/news/news_screen.dart - News browsing interface

lib/animations/slide_up.dart - Weather data slide animation

lib/services/weather_service.dart - Weather API integration


dependencies:
 
  #-- icons
  iconsax: ^0.0.8
  cupertino_icons: ^1.0.8

  #fonts
  google_fonts: ^6.2.1

  #--firebase
  firebase_core: ^3.9.0
  cloud_firestore: ^5.6.1
  firebase_auth: ^5.4.0

  #-- utility Packages
  intl: ^0.20.2
  smooth_page_indicator: ^1.2.0
  flutter_svg: ^2.0.10+1
  flutter_native_splash: ^2.4.1

  #-- state management
  get: ^4.6.6
  get_storage: ^2.1.1

   #--other items
  lottie: ^3.1.3
  connectivity_plus: ^4.0.1
  shimmer: ^3.0.0

  #-- http
  http: ^1.4.0

  #-- location
  geolocator: ^14.0.1
  geocoding: ^4.0.0