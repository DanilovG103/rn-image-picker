import React, {useState} from 'react';
import {SafeAreaView, NativeModules, Button, Image} from 'react-native';

const {MyAppModule} = NativeModules;

const App = () => {
  const [uri, setUri] = useState('');
  const onPress = async () => {
    try {
      const file = await MyAppModule.chooseFile();
      setUri(file);
    } catch (error) {
      console.log(error);
    }
  };

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
