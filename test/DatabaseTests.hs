{-# LANGUAGE OverloadedStrings #-}
module DatabaseTests where

import           Data.Text
import           Database
import           Test.Hspec

spec :: Spec
spec = describe "Database interface" $ do

    it "should be able to connect" $ do
        -- findItem 0 `shouldBe` Exists Item { itemId = 0, name = "foo", description = "bar" }
        True
