{-# LANGUAGE OverloadedStrings #-}
module DatabaseSpec where

import           Data.Text
import           Test.Hspec

import           Database
import           Item

spec :: Spec
spec = describe "Database interface" $ do

    it "should be able to connect" $ do
        findItemById 1 `shouldReturn` Available (Item 1 "Nintendo Switch" "Best console of its generation")
        findItemById 2 `shouldReturn` Available (Item 2 "Playstation 4" "Almost as good as the Switch")
        findItemById 3 `shouldReturn` NotAvailable
        findItemById 4 `shouldReturn` DoesNotExists
