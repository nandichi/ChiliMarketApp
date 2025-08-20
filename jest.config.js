module.exports = {
  preset: 'react-native',
  testPathIgnorePatterns: ['/node_modules/', '/android/', '/ios/'],
  transformIgnorePatterns: [
    'node_modules/(?!(@react-native|react-native|react-native-.*|@react-navigation/.*|@react-native-community/.*)/)',
  ],
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
};
