import Control.Monad

bind :: Monad m => (a -> m b) -> m a -> m b
bind famb ma = join $ fmap famb ma
