;; contribution-manager.clar
;; ArtCollab Contribution Management Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-invalid-contribution (err u101))

;; Data Variables
(define-data-var next-contribution-id uint u0)

;; Data Maps
(define-map contributions
    { contribution-id: uint }
    {
        artist: principal,
        artwork-id: uint,
        contribution-type: (string-ascii 20),
        metadata-url: (string-ascii 256),
        timestamp: uint,
        weight: uint,
        status: (string-ascii 10)
    }
)

(define-map artwork-contributors
    { artwork-id: uint }
    { contributors: (list 50 principal) }
)

;; Public Functions
(define-public (submit-contribution 
    (artwork-id uint)
    (contribution-type (string-ascii 20))
    (metadata-url (string-ascii 256))
    (weight uint))
    (let 
        ((contribution-id (+ (var-get next-contribution-id) u1)))
        (begin
            (asserts! (is-valid-contribution contribution-type weight) err-invalid-contribution)
            (map-set contributions
                { contribution-id: contribution-id }
                {
                    artist: tx-sender,
                    artwork-id: artwork-id,
                    contribution-type: contribution-type,
                    metadata-url: metadata-url,
                    timestamp: block-height,  ;; Fixed: Using block-height directly
                    weight: weight,
                    status: "pending"
                }
            )
            (var-set next-contribution-id contribution-id)
            (ok contribution-id)
        )
    )
)

;; Private Functions
(define-private (is-valid-contribution (type (string-ascii 20)) (weight uint))
    (and
        (or 
            (is-eq type "concept")
            (is-eq type "linework")
            (is-eq type "coloring")
            (is-eq type "background")
            (is-eq type "details")
        )
        (<= weight u100)
    )
)

;; Read-Only Functions
(define-read-only (get-contribution (contribution-id uint))
    (map-get? contributions { contribution-id: contribution-id })
)

(define-read-only (get-artwork-contributors (artwork-id uint))
    (map-get? artwork-contributors { artwork-id: artwork-id })
)
