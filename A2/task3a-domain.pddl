(define (domain delivery)

    (:requirements :typing :numeric-fluents)
    
    (:types
        location package robot
    )
    
    (:predicates
        (connected ?location1 - location ?location2 - location )
        (at-package ?p - package  ?l - location)
        (at-robot ?r - robot ?l - location)
        (carries ?r -robot ?p - package)
    )
    
    (:functions
        (weighs ?package - package)
        (capacity ?robot - robot)
        (load ?robot - robot)
    )
    
    (:action move
        :parameters(?bot - robot ?from - location ?to - location)
        :precondition (and
            (at-robot ?bot ?from)
            (connected ?from ?to)
        )
        :effect (and
            (not (at-robot ?bot ?from))
            (at-robot ?bot ?to)
        )
    )
    
    (:action pickup
        :parameters(?bot - robot ?package - package ?loc - location)
        :precondition (and
            (at-robot ?bot ?loc)
            (at-package ?package ?loc)
            (<= (+ (load ?bot) (weighs ?package)) (capacity ?bot))
        )
        :effect (and
            (not (at-package ?package ?loc))
            (carries ?bot ?package)
            (increase (load ?bot) (weighs ?package))
        )
    )
    
    (:action putdown
        :parameters(?bot - robot ?package - package ?loc - location)
        :precondition (and
            (at-robot ?bot ?loc)
            (carries ?bot ?package)
        )
        :effect (and 
            (at-package ?package ?loc)
            (not (carries ?bot ?package))
            (decrease (load ?bot) (weighs ?package))
        )
    )
)

