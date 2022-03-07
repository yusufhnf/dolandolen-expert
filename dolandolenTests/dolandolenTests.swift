//
//  dolandolenTests.swift
//  dolandolenTests
//
//  Created by Yusuf Umar Hanafi on 11/08/21.
//

import XCTest
import Core
import RxSwift
@testable import Game

class DolandolenTests: XCTestCase {
    let disposeBag = DisposeBag()
    static var responseJson: String = """
       {
           "count": 612416,
           "next": "https://api.rawg.io/api/games?key=fd3b0b05733a4e8ba830635a72b58bfc&page=2",
           "previous": null,
           "results": [
               {
                   "id": 3498,
                   "slug": "grand-theft-auto-v",
                   "name": "Grand Theft Auto V",
                   "released": "2013-09-17",
                   "tba": false,
                   "background_image": "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
                   "rating": 4.48,
                   "rating_top": 5,
                   "ratings": [
                       {
                           "id": 5,
                           "title": "exceptional",
                           "count": 2989,
                           "percent": 58.97
                       },
                       {
                           "id": 4,
                           "title": "recommended",
                           "count": 1676,
                           "percent": 33.06
                       },
                       {
                           "id": 3,
                           "title": "meh",
                           "count": 319,
                           "percent": 6.29
                       },
                       {
                           "id": 1,
                           "title": "skip",
                           "count": 85,
                           "percent": 1.68
                       }
                   ],
                   "ratings_count": 5013,
                   "reviews_text_count": 33,
                   "added": 15648,
                   "added_by_status": {
                       "yet": 392,
                       "owned": 9308,
                       "beaten": 4182,
                       "toplay": 435,
                       "dropped": 767,
                       "playing": 564
                   },
                   "metacritic": 97,
                   "playtime": 71,
                   "suggestions_count": 407,
                   "updated": "2021-08-20T12:42:02",
                   "user_game": null,
                   "reviews_count": 5069,
                   "saturated_color": "0f0f0f",
                   "dominant_color": "0f0f0f",
                   "platforms": [
                       {
                           "platform": {
                               "id": 187,
                               "name": "PlayStation 5",
                               "slug": "playstation5",
                               "image": null,
                               "year_end": null,
                               "year_start": 2020,
                               "games_count": 359,
                               "image_background": "https://media.rawg.io/media/games/1f4/1f47a270b8f241e4676b14d39ec620f7.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": null,
                           "requirements_ru": null
                       },
                       {
                           "platform": {
                               "id": 18,
                               "name": "PlayStation 4",
                               "slug": "playstation4",
                               "image": null,
                               "year_end": null,
                               "year_start": null,
                               "games_count": 6089,
                               "image_background": "https://media.rawg.io/media/games/942/9424d6bb763dc38d9378b488603c87fa.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": null,
                           "requirements_ru": null
                       },
                       {
                           "platform": {
                               "id": 16,
                               "name": "PlayStation 3",
                               "slug": "playstation3",
                               "image": null,
                               "year_end": null,
                               "year_start": null,
                               "games_count": 3627,
                               "image_background": "https://media.rawg.io/media/games/234/23410661770ae13eac11066980834367.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": null,
                           "requirements_ru": null
                       },
                       {
                           "platform": {
                               "id": 14,
                               "name": "Xbox 360",
                               "slug": "xbox360",
                               "image": null,
                               "year_end": null,
                               "year_start": null,
                               "games_count": 2725,
                               "image_background": "https://media.rawg.io/media/games/bc0/bc06a29ceac58652b684deefe7d56099.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": null,
                           "requirements_ru": null
                       },
                       {
                           "platform": {
                               "id": 4,
                               "name": "PC",
                               "slug": "pc",
                               "image": null,
                               "year_end": null,
                               "year_start": null,
                               "games_count": 363936,
                               "image_background": "https://media.rawg.io/media/games/588/588c6bdff3d4baf66ec36b1c05b793bf.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": {
                               "minimum": "Minimum:OS: Windows 10 64 Bit, Windows 8.1 64 Bit",
                               "recommended": "Recommended:OS: Windows 10 64 Bit"
                           },
                           "requirements_ru": null
                       },
                       {
                           "platform": {
                               "id": 1,
                               "name": "Xbox One",
                               "slug": "xbox-one",
                               "image": null,
                               "year_end": null,
                               "year_start": null,
                               "games_count": 4935,
                               "image_background": "https://media.rawg.io/media/games/ad2/ad2ffdf80ba993654f31da045bc02456.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": null,
                           "requirements_ru": null
                       },
                       {
                           "platform": {
                               "id": 186,
                               "name": "Xbox Series S/X",
                               "slug": "xbox-series-x",
                               "image": null,
                               "year_end": null,
                               "year_start": 2020,
                               "games_count": 303,
                               "image_background": "https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg"
                           },
                           "released_at": "2013-09-17",
                           "requirements_en": null,
                           "requirements_ru": null
                       }
                   ],
                   "parent_platforms": [
                       {
                           "platform": {
                               "id": 1,
                               "name": "PC",
                               "slug": "pc"
                           }
                       },
                       {
                           "platform": {
                               "id": 2,
                               "name": "PlayStation",
                               "slug": "playstation"
                           }
                       },
                       {
                           "platform": {
                               "id": 3,
                               "name": "Xbox",
                               "slug": "xbox"
                           }
                       }
                   ],
                   "genres": [
                       {
                           "id": 4,
                           "name": "Action",
                           "slug": "action",
                           "games_count": 127576,
                           "image_background": "https://media.rawg.io/media/games/f87/f87457e8347484033cb34cde6101d08d.jpg"
                       },
                       {
                           "id": 3,
                           "name": "Adventure",
                           "slug": "adventure",
                           "games_count": 93985,
                           "image_background": "https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg"
                       }
                   ],
                   "stores": [
                       {
                           "id": 290375,
                           "store": {
                               "id": 3,
                               "name": "PlayStation Store",
                               "slug": "playstation-store",
                               "domain": "store.playstation.com",
                               "games_count": 7650,
                               "image_background": "https://media.rawg.io/media/games/bc8/bc845a71d60a87ea5736b40c2d3a0fdf.jpg"
                           }
                       },
                       {
                           "id": 438095,
                           "store": {
                               "id": 11,
                               "name": "Epic Games",
                               "slug": "epic-games",
                               "domain": "epicgames.com",
                               "games_count": 581,
                               "image_background": "https://media.rawg.io/media/games/daa/daaee07fcb40744d90cf8142f94a241f.jpg"
                           }
                       },
                       {
                           "id": 290376,
                           "store": {
                               "id": 1,
                               "name": "Steam",
                               "slug": "steam",
                               "domain": "store.steampowered.com",
                               "games_count": 54688,
                               "image_background": "https://media.rawg.io/media/games/f87/f87457e8347484033cb34cde6101d08d.jpg"
                           }
                       },
                       {
                           "id": 290377,
                           "store": {
                               "id": 7,
                               "name": "Xbox 360 Store",
                               "slug": "xbox360",
                               "domain": "marketplace.xbox.com",
                               "games_count": 1908,
                               "image_background": "https://media.rawg.io/media/games/b49/b4912b5dbfc7ed8927b65f05b8507f6c.jpg"
                           }
                       },
                       {
                           "id": 290378,
                           "store": {
                               "id": 2,
                               "name": "Xbox Store",
                               "slug": "xbox-store",
                               "domain": "microsoft.com",
                               "games_count": 4507,
                               "image_background": "https://media.rawg.io/media/games/942/9424d6bb763dc38d9378b488603c87fa.jpg"
                           }
                       }
                   ],
                   "clip": null,
                   "tags": [
                       {
                           "id": 31,
                           "name": "Singleplayer",
                           "slug": "singleplayer",
                           "language": "eng",
                           "games_count": 129678,
                           "image_background": "https://media.rawg.io/media/games/120/1201a40e4364557b124392ee50317b99.jpg"
                       },
                       {
                           "id": 40847,
                           "name": "Steam Achievements",
                           "slug": "steam-achievements",
                           "language": "eng",
                           "games_count": 22901,
                           "image_background": "https://media.rawg.io/media/games/da1/da1b267764d77221f07a4386b6548e5a.jpg"
                       },
                       {
                           "id": 7,
                           "name": "Multiplayer",
                           "slug": "multiplayer",
                           "language": "eng",
                           "games_count": 27013,
                           "image_background": "https://media.rawg.io/media/games/46d/46d98e6910fbc0706e2948a7cc9b10c5.jpg"
                       },
                       {
                           "id": 13,
                           "name": "Atmospheric",
                           "slug": "atmospheric",
                           "language": "eng",
                           "games_count": 15592,
                           "image_background": "https://media.rawg.io/media/games/b7d/b7d3f1715fa8381a4e780173a197a615.jpg"
                       },
                       {
                           "id": 40836,
                           "name": "Full controller support",
                           "slug": "full-controller-support",
                           "language": "eng",
                           "games_count": 10638,
                           "image_background": "https://media.rawg.io/media/games/310/3106b0e012271c5ffb16497b070be739.jpg"
                       },
                       {
                           "id": 42,
                           "name": "Great Soundtrack",
                           "slug": "great-soundtrack",
                           "language": "eng",
                           "games_count": 3159,
                           "image_background": "https://media.rawg.io/media/games/e46/e462e92b46e8df13e78a806191610d47.jpg"
                       },
                       {
                           "id": 24,
                           "name": "RPG",
                           "slug": "rpg",
                           "language": "eng",
                           "games_count": 12516,
                           "image_background": "https://media.rawg.io/media/games/4ba/4ba9b4b68ffcc7019b112174883ba4d6.jpg"
                       },
                       {
                           "id": 18,
                           "name": "Co-op",
                           "slug": "co-op",
                           "language": "eng",
                           "games_count": 7178,
                           "image_background": "https://media.rawg.io/media/games/46d/46d98e6910fbc0706e2948a7cc9b10c5.jpg"
                       },
                       {
                           "id": 36,
                           "name": "Open World",
                           "slug": "open-world",
                           "language": "eng",
                           "games_count": 4141,
                           "image_background": "https://media.rawg.io/media/games/d82/d82990b9c67ba0d2d09d4e6fa88885a7.jpg"
                       },
                       {
                           "id": 411,
                           "name": "cooperative",
                           "slug": "cooperative",
                           "language": "eng",
                           "games_count": 2963,
                           "image_background": "https://media.rawg.io/media/games/5bb/5bb55ccb8205aadbb6a144cf6d8963f1.jpg"
                       },
                       {
                           "id": 8,
                           "name": "First-Person",
                           "slug": "first-person",
                           "language": "eng",
                           "games_count": 15163,
                           "image_background": "https://media.rawg.io/media/games/736/73619bd336c894d6941d926bfd563946.jpg"
                       },
                       {
                           "id": 149,
                           "name": "Third Person",
                           "slug": "third-person",
                           "language": "eng",
                           "games_count": 5081,
                           "image_background": "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
                       },
                       {
                           "id": 4,
                           "name": "Funny",
                           "slug": "funny",
                           "language": "eng",
                           "games_count": 14877,
                           "image_background": "https://media.rawg.io/media/games/4a0/4a0a1316102366260e6f38fd2a9cfdce.jpg"
                       },
                       {
                           "id": 37,
                           "name": "Sandbox",
                           "slug": "sandbox",
                           "language": "eng",
                           "games_count": 3872,
                           "image_background": "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
                       },
                       {
                           "id": 123,
                           "name": "Comedy",
                           "slug": "comedy",
                           "language": "eng",
                           "games_count": 7097,
                           "image_background": "https://media.rawg.io/media/games/8ca/8ca40b562a755d6a0e30d48e6c74b178.jpg"
                       },
                       {
                           "id": 150,
                           "name": "Third-Person Shooter",
                           "slug": "third-person-shooter",
                           "language": "eng",
                           "games_count": 1719,
                           "image_background": "https://media.rawg.io/media/games/5bb/5bb55ccb8205aadbb6a144cf6d8963f1.jpg"
                       },
                       {
                           "id": 62,
                           "name": "Moddable",
                           "slug": "moddable",
                           "language": "eng",
                           "games_count": 590,
                           "image_background": "https://media.rawg.io/media/games/5fa/5fae5fec3c943179e09da67a4427d68f.jpg"
                       },
                       {
                           "id": 144,
                           "name": "Crime",
                           "slug": "crime",
                           "language": "eng",
                           "games_count": 1915,
                           "image_background": "https://media.rawg.io/media/games/10d/10d19e52e5e8415d16a4d344fe711874.jpg"
                       },
                       {
                           "id": 62349,
                           "name": "vr mod",
                           "slug": "vr-mod",
                           "language": "eng",
                           "games_count": 19,
                           "image_background": "https://media.rawg.io/media/games/bda/bdab2603c0dc67268d0610449bc7df16.jpg"
                       }
                   ],
                   "esrb_rating": {
                       "id": 4,
                       "name": "Mature",
                       "slug": "mature"
                   },
                   "short_screenshots": [
                       {
                           "id": -1,
                           "image": "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
                       },
                       {
                           "id": 1827221,
                           "image": "https://media.rawg.io/media/screenshots/a7c/a7c43871a54bed6573a6a429451564ef.jpg"
                       },
                       {
                           "id": 1827222,
                           "image": "https://media.rawg.io/media/screenshots/cf4/cf4367daf6a1e33684bf19adb02d16d6.jpg"
                       },
                       {
                           "id": 1827223,
                           "image": "https://media.rawg.io/media/screenshots/f95/f9518b1d99210c0cae21fc09e95b4e31.jpg"
                       },
                       {
                           "id": 1827225,
                           "image": "https://media.rawg.io/media/screenshots/a5c/a5c95ea539c87d5f538763e16e18fb99.jpg"
                       },
                       {
                           "id": 1827226,
                           "image": "https://media.rawg.io/media/screenshots/a7e/a7e990bc574f4d34e03b5926361d1ee7.jpg"
                       },
                       {
                           "id": 1827227,
                           "image": "https://media.rawg.io/media/screenshots/592/592e2501d8734b802b2a34fee2df59fa.jpg"
                       }
                   ]
               }
           ]
       }
       """
    
    static var fakeResponse: ResultGame = ResultGame(
        name: "test",
        backgroundImage: "imagestest",
        rating: 3.5,
        ratingTop: 40,
        idGame: 1,
        released: "2021-08-31"
    )
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testExample() throws {
        // Given
        let dataSource = GamesRemoteMock(endpoint: "test", key: "a")
        var test: [ResultGame] = []
        // When
        dataSource.execute(request: "")
            .subscribe { (result) in
                test = result
            }.disposed(by: disposeBag)
        XCTAssert(dataSource.verify())
        XCTAssertEqual(test.count, 1)
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }
    
}

extension DolandolenTests {
    
    class GamesRemoteMock: DomainRemoteDataSource {
        
        internal init(endpoint: String, key: String) {
            self.endpoint = endpoint
            self.key = key
        }
        
        var endpoint: String
        var key: String
        
        var functionWasCalled = false
        
        func execute(request: String?) -> Observable<[ResultGame]> {
            return Observable<[ResultGame]>.create {observer in
                
                if !self.endpoint.isEmpty {
                    if !self.key.isEmpty {
                        do {
                            let value = try JSONDecoder().decode(GameResponse.self, from: Data(responseJson.utf8))
                            observer.onNext(value.results)
                            observer.onCompleted()
                            self.functionWasCalled = true
                        } catch {
                            observer.onError(URLError.invalidResponse)
                        }
                    } else {
                        print("Doesn't Have API KEY")
                        observer.onError(URLError.invalidResponse)
                        
                    }
                }
                return Disposables.create()
            }
        }
        
        func verify() -> Bool {
            return functionWasCalled
        }
    }
    
}
