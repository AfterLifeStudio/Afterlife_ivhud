import { configureStore } from '@reduxjs/toolkit'
import { settingsSlice } from './settings/settings'

export const store = configureStore({
  reducer: {settings: settingsSlice},
})