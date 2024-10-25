import { useState } from 'react'
import './App.css'
import Hud from './components/Hud'
import { createTheme, MantineProvider } from '@mantine/core';
import {emotionTransform, MantineEmotionProvider,} from '@mantine/emotion';
import { useConfig } from './providers/configprovider';
import { Provider } from 'react-redux'
import { store } from './store/store';


const theme = createTheme({
  primary: 'blue'
});

function App() {



  return (
    <>

    <MantineProvider theme={{...theme}}>
      <MantineEmotionProvider>
      <Provider store={store}>
        <Hud />
        </Provider>
        </MantineEmotionProvider>
    </MantineProvider>
    </>
  )
}

export default App
