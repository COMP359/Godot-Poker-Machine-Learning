extends GutTest

class TestDealerFunction:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()

	func test_check_players_folded_case_one():
		dealer.players[0].has_folded = true
		dealer.players[1].has_folded = true
		dealer.players[2].has_folded = true
		dealer.players[3].has_folded = true
		assert_eq(dealer.check_players_folded(), true)

	func test_check_players_folded_case_two():
		dealer.players[0].has_folded = true
		dealer.players[1].has_folded = true
		dealer.players[2].has_folded = true
		dealer.players[3].has_folded = false
		assert_eq(dealer.check_players_folded(), true)

	func test_check_players_folded_case_three():
		dealer.players[0].has_folded = false
		dealer.players[1].has_folded = false
		dealer.players[2].has_folded = false
		dealer.players[3].has_folded = false
		assert_eq(dealer.check_players_folded(), false)
