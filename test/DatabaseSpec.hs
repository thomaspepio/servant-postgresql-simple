{-# LANGUAGE OverloadedStrings #-}
module DatabaseSpec where

import           Data.Text
import           Test.Hspec

import           Database
import           Model

spec :: Spec
spec = describe "Database interface" $ do

    it "should be able to connect" $ do
        findItem 1 >>= (`shouldBe` Exists Item {itemId = 1, name = "Nintendo Switch", description = "Best console of its generation", quantity = 10})
        findItem 2 >>= (`shouldBe` Exists Item {itemId = 2, name = "Playstation 4", description = "Almost as good as the Switch", quantity = 20})
        findItem 3 >>= (`shouldBe` NotAvailable)
        findItem 4 >>= (`shouldBe` DoesNotExists)
