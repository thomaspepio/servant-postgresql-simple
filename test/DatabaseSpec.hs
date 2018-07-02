{-# LANGUAGE OverloadedStrings #-}
module DatabaseSpec where

import           Data.Text
import           Test.Hspec

import           Database
import           Item

spec :: Spec
spec = describe "Database interface" $ do

    it "should be able to connect" $ do
        findItemById 1 >>= (`shouldBe` Exists Item {itemId = 1, name = "Nintendo Switch", description = "Best console of its generation"})
        findItemById 2 >>= (`shouldBe` Exists Item {itemId = 2, name = "Playstation 4", description = "Almost as good as the Switch"})
        findItemById 3 >>= (`shouldBe` NotAvailable)
        findItemById 4 >>= (`shouldBe` DoesNotExists)
