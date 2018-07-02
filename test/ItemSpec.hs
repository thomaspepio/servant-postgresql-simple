{-# LANGUAGE OverloadedStrings #-}
module ItemSpec where

import           Data.Text
import           Test.Hspec

import           Item

spec :: Spec
spec = describe "Operations on Items" $ do

    let toothBrush = Item { itemId = 1, name = "toothbrush", description = "a toothbrush" }
    let toothBrushStock = Stock { item = toothBrush, quantity = 1 }

    it "should allow to add a quantity of items to a stock" $ do
        addStock 1 toothBrushStock `shouldBe` Stock { item = toothBrush, quantity = 2 }

    it "should allow to withdraw a quantity of items to a stock" $ do
        removeStock 1 toothBrushStock `shouldBe` Stock { item = toothBrush, quantity = 0 }

    it "should not allow a stock quantity to go bellow zero" $ do
        removeStock 2 toothBrushStock `shouldBe` Stock { item = toothBrush, quantity = 0 }
