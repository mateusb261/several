data Termo = Termo { coef :: Int, grau :: Int } deriving (Eq, Show)

multTermo :: Termo -> Termo -> Termo
multTermo t1 t2 = Termo (coef t1 * coef t2) (grau t1 + grau t2)

multTermoTermos :: Termo -> [Termo] -> [Termo]
multTermoTermos t [] = []
multTermoTermos t (t':ts) = multTermo t t' : multTermoTermos t ts

multTermos :: [Termo] -> [Termo] -> [Termo]
multTermos [] ts = []
multTermos (t:ts) ts' = somaTermos (multTermoTermos t ts') (multTermos ts ts')

somaTermo :: Termo -> Termo -> Termo
somaTermo t1 t2 = Termo (coef t1 + coef t2) (grau t1)

somaTermos :: [Termo] -> [Termo] -> [Termo]
somaTermos [] ts = ts
somaTermos ts [] = ts
somaTermos (t1:ts1) (t2:ts2)
  | grau t1 == grau t2 = somaTermo t1 t2 : somaTermos ts1 ts2
  | grau t1 > grau t2 = t1 : somaTermos ts1 (t2:ts2)
  | otherwise = t2 : somaTermos (t1:ts1) ts2

mostraPolinomio :: [Termo] -> String
mostraPolinomio [] = ""
mostraPolinomio [t] = mostraTermo t
mostraPolinomio (t:ts) = mostraTermo t ++ " + " ++ mostraPolinomio ts

mostraTermo :: Termo -> String
mostraTermo t = show (coef t) ++ "x^" ++ show (grau t)

main :: IO ()
main = do
  let termos1 = [Termo 5 1, Termo 3 2, Termo (-2) 0, Termo 4 3]
  let termos2 = [Termo 2 2, Termo 1 0, Termo 3 4]
  let produto = multTermos termos1 termos2
  putStrLn ("O produto dos polinômios " ++ mostraPolinomio termos1 ++ " e " ++ mostraPolinomio termos2 ++ " é "
  ++ mostraPolinomio produto)
