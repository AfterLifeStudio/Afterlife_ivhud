import { configureStore } from '@reduxjs/toolkit'
import counterReducer from "./settings/settingsSlice"


export const store = configureStore({
    reducer: {
        settings: counterReducer,
    },
})

