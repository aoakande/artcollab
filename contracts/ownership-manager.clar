;; ownership-manager.clar
;; ArtCollab Ownership Management Contract

;; Error Constants
(define-constant ERR_NOT_AUTHORIZED (err u401))
(define-constant ERR_INVALID_SHARES (err u402))
(define-constant ERR_ARTWORK_EXISTS (err u403))

;; Data Maps
(define-map artwork-ownership
    { artwork-id: uint }
    {
        creator: principal,
        contributors: (list 50 {
            address: principal,
            share: uint,
            contribution-type: (string-ascii 20)
        }),
        total-shares: uint,
        created-at: uint,
        status: (string-ascii 10)
    }
)

(define-map contributor-artworks
    { contributor: principal }
    { artwork-ids: (list 50 uint) }
)
