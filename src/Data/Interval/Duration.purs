module Data.Interval.Duration
  ( Duration(..)
  , DurationComponent(..)
  , year
  , month
  , week
  , day
  , hour
  , minute
  , second
  , millisecond
  ) where

import Prelude
import Data.Map as Map
import Data.Monoid (class Monoid, mempty)
import Data.Newtype (class Newtype)

newtype Duration = Duration (Map.Map DurationComponent Number)

derive instance eqDuration :: Eq Duration
derive instance ordDuration :: Ord Duration
derive instance newtypeDuration :: Newtype Duration _

instance showDuration :: Show Duration where
  show (Duration d) = "(Duration " <> show d <> ")"

instance semigroupDuration :: Semigroup Duration where
  append (Duration a) (Duration b) = Duration (Map.unionWith (+) a b)

instance monoidDuration :: Monoid Duration where
  mempty = Duration mempty

data DurationComponent = Year | Month | Day | Hour | Minute | Second
derive instance eqDurationComponent :: Eq DurationComponent
derive instance ordDurationComponent :: Ord DurationComponent

instance showDurationComponent :: Show DurationComponent where
  show Year = "Year"
  show Month = "Month"
  show Day = "Day"
  show Hour = "Hour"
  show Minute = "Minute"
  show Second = "Second"


week :: Number -> Duration
week = durationFromComponent Day <<< (_ * 7.0)

year :: Number -> Duration
year = durationFromComponent Year

month :: Number -> Duration
month = durationFromComponent Month

day :: Number -> Duration
day = durationFromComponent Day

hour :: Number -> Duration
hour = durationFromComponent Hour

minute :: Number -> Duration
minute = durationFromComponent Minute

second :: Number -> Duration
second = durationFromComponent Second

millisecond :: Number -> Duration
millisecond = durationFromComponent Second <<< (_ / 1000.0)

durationFromComponent :: DurationComponent -> Number -> Duration
durationFromComponent k v = Duration (Map.singleton k v)
