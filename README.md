# Chili Market App

Een professionele React Native app voor Chili Market met native navigatie, splash screen en moderne UI componenten.

## Features

✅ **Native App Ervaring**

- Professionele splash screen met animaties
- Tab navigatie met 5 hoofdsecties
- Custom design systeem met Chili Market branding
- Native UI componenten in plaats van alleen WebView

✅ **Schermen**

- **Home**: Zoekbalk, categorieën, uitgelichte producten, snelle acties
- **Categorieën**: Grid layout met alle productcategorieën
- **Zoeken**: Geavanceerde zoekfunctie met filters
- **Winkelwagen**: Volledig functionele winkelwagen met checkout
- **Profiel**: Gebruikersprofiel met statistieken en instellingen

✅ **Design & UX**

- Consistent kleurenpalet geïnspireerd door chili/spice thema
- Material Design iconen
- Responsive layout voor alle schermformaten
- Soepele animaties en transities
- Professional shadows en elevation

✅ **Technische Features**

- TypeScript voor type safety
- Gestructureerde mappenindeling
- Modulaire componenten
- Native splash screen configuratie
- WebView integratie optie voor volledige website

## Installatie

### Prerequisites

- Node.js (>= 18)
- React Native development environment
- iOS Simulator (voor iOS development)
- Android Studio (voor Android development)

### Setup

1. **Installeer dependencies:**

```bash
npm install
```

2. **iOS Setup:**

```bash
cd ios && pod install && cd ..
```

3. **Start Metro:**

```bash
npm start
```

4. **Run iOS:**

```bash
npm run ios
```

5. **Run Android:**

```bash
npm run android
```

## App Architectuur

```
src/
├── components/          # Herbruikbare UI componenten
│   └── SplashScreen.tsx
├── constants/           # App constanten en configuratie
│   └── colors.ts
├── navigation/          # Navigatie setup
│   ├── AppNavigator.tsx
│   └── TabNavigator.tsx
├── screens/             # App schermen
│   ├── HomeScreen.tsx
│   ├── CategoriesScreen.tsx
│   ├── SearchScreen.tsx
│   ├── CartScreen.tsx
│   ├── ProfileScreen.tsx
│   └── WebViewScreen.tsx
└── types/               # TypeScript type definities
    └── navigation.ts
```

## Kleuren Schema

De app gebruikt een consistent kleurenpalet:

- **Primary**: #E53E3E (Chili rood)
- **Secondary**: #FF6B35 (Warm oranje)
- **Accent**: #FFA500 (Goud)
- **Success**: #38A169 (Groen)
- **Text**: #2D3748 (Donkergrijs)

## Native Features

- ✅ Splash screen met logo animatie
- ✅ Tab navigatie met iconen
- ✅ Native headers en status bar styling
- ✅ Material Design componenten
- ✅ Responsive grid layouts
- ✅ Native scrolling en gestures
- ✅ Professional shadows en elevations

## WebView Integratie

De app bevat nog steeds een WebView optie voor gebruikers die de volledige website willen bekijken:

- Intelligent fallback naar chili-market.com
- Custom user agent voor app identificatie
- Optimized voor mobile ervaring

## Development

### Code Style

- TypeScript strict mode
- Functional components met hooks
- Consistent naming conventions
- Modulaire architectuur

### Testing

```bash
npm test
```

### Linting

```bash
npm run lint
```

## Building for Production

### iOS

```bash
npm run build:ios
```

### Android

```bash
npm run build:android
```

## Volgende Stappen

1. **Backend Integratie**: Koppel echte API's voor producten en bestellingen
2. **Authenticatie**: Implementeer login/register functionaliteit
3. **Push Notifications**: Voeg push notifications toe voor bestellingen
4. **Offline Support**: Implementeer offline caching
5. **Analytics**: Voeg analytics tracking toe
6. **Deep Linking**: Implementeer deep linking support

## Support

Voor vragen of problemen, neem contact op met het development team.
