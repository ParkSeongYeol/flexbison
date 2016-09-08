# flexbison
1. %token : 터미널 항목을 사용하겠다고 알려준다. c로 컴파일 될 때 #define 문으로 변형된다
            데이터 타입이 %union으로 되어 있을 경우 %token <intval> NUMBER 식으로 사용한다
            대신에 %left, %right, %nonassoc(?)을 사용해도 된다
2. %type : 논터미널 항목의 데이터형을 알릴 때 사용한다
3. %nonassoc : 연속으로 (in a row) 나오면 runtime에 에러를 발생시킨다
   %precedence : %left, %right, %nonassoc은 associativity와 precedence 둘 다 설정하는데 %precedence는 precedence만 설정한다
              예) %precedence THEN
                  %precedence ELSE
                -> 이렇게하면 ELSE에 우선순위가 있음
