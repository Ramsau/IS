(define (problem delivery-problem)
    (:domain delivery)
    
    (:objects
        package1 package2 package3 - package
        A B C D E F G H I - location
        robot - robot
    )
    
    (:init
        (connected A B)
        (connected A D)
        (connected B A)
        (connected B C)
        (connected B D)
        (connected C B)
        (connected C E)
        (connected D A)
        (connected D B)
        (connected D E)
        (connected D F)
        (connected E C)
        (connected E D)
        (connected F D)
        (connected F H)
        (connected G H)
        (connected H F)
        (connected H G)
        (connected H I)
        (connected I H)
        (= (weighs package1) 20)
        (= (weighs package2) 10)
        (= (weighs package3) 50)
        (at-robot robot A)
        (= (capacity robot) 50)
        (= (load robot) 0)
        (at-package package1 F)
        (at-package package2 E)
        (at-package package3 G)
    )
    
    (:goal
        (and
            (at-package package1 H)
            (at-package package2 H)
            (at-package package3 B)
            (at-robot robot A)
        )
    )
    
)