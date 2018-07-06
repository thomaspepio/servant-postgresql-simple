{-# LANGUAGE OverloadedStrings #-}
module PersistenceSpec where

import           Data.Text
import           Test.Hspec

import           Item
import           Persistence

spec :: Spec
spec = describe "Persistence interface" $ do

    it "should be able to connect" $ do
        findItemById 1 `shouldReturn` Available (Item 1 "Nintendo Switch" "Best console of its generation")
        findItemById 2 `shouldReturn` Available (Item 2 "Playstation 4" "Almost as good as the Switch")
        findItemById 3 `shouldReturn` NotAvailable
        findItemById 4 `shouldReturn` DoesNotExists
