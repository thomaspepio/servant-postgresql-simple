{-# LANGUAGE OverloadedStrings #-}
module PersistenceSpec where

import           Data.Text
import           Test.Hspec

import           Item
import           Persistence

spec :: Spec
spec = describe "Persistence interface" $ do

    let distinction = Item 1 "La Distinction" "De Pierre Bourdieu"
    let misereDuMonde = Item 2 "La misère du monde" "Ouvrage collectif rédigé sous la direction de Pierre Bourdieu"
    let desirServitude = Item 3 "Capitalisme et désir de servitude" "De Frédéric Lordon"
    let enjeuSalaire = Item 4 "L'enjeu du salaire" "Par Bernard Friot"

    describe "finding items " $ do
        it "should be able to fetch item by name and description" $ do
            findItemByNameAndDescription distinction `shouldReturn` Available distinction
            findItemByNameAndDescription misereDuMonde `shouldReturn` Available misereDuMonde
            findItemByNameAndDescription desirServitude `shouldReturn` Available desirServitude

        it "should be able to fetch item availabilities" $ do
            findItemById 1 `shouldReturn` Available distinction
            findItemById 2 `shouldReturn` Available misereDuMonde
            findItemById 3 `shouldReturn` NotAvailable
            findItemById 4 `shouldReturn` DoesNotExists

    describe "inserting and deleting items" $ do
        it "should be able to insert items" $
            addNewItem enjeuSalaire `shouldReturn` Right 1 -- 1 is the number of rows affected by the insert

        it "should not insert items if they already exists" $
            addNewItem distinction `shouldReturn` Left "Item already exists"