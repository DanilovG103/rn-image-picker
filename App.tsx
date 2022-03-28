import React, {useState} from 'react';
import {
  SafeAreaView,
  NativeModules,
  Button,
  Image,
  Platform,
} from 'react-native';

const {MyAppModule} = NativeModules;

const App = () => {
  const [uri, setUri] = useState('');
  const onPress = async () => {
    try {
      if (Platform.OS === 'android') {
        const file = await MyAppModule.chooseFile();
        setUri(file);
      } else {
        const smth = await MyAppModule.chooseFile();
      }
    } catch (error) {
      console.log(error);
    }
  };

  console.log(uri);
  return (
    <SafeAreaView
      style={{flex: 1, alignItems: 'center', justifyContent: 'center'}}>
      <Button onPress={onPress} title="Open picker" />
      <Image
        source={!uri ? require('./artist.jpg') : {uri}}
        style={{width: 75, height: 75}}
      />
    </SafeAreaView>
  );
};

export default App;
