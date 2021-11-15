require_relative "../_plugins/filters"
require "test/unit"

class TestSetOfSkillsFilters < Test::Unit::TestCase

	def test_add_noscript_for_lazyload_img()
		tests = [
			{
				input: 'should not be changed',
				expected_result: 'should not be changed'
			},
			{
				input: '<img src="data:image/png;abcdef" data-original="/img/a.png">',
				expected_result: '<img src="data:image/png;abcdef" data-original="/img/a.png"><noscript><img src="/img/a.png">'
			}
		]
		for tc in tests
			result = SetOfSkillsFilters.add_noscript_for_lazyload_img(tc[:input])
			assert_equal(tc[:expected_result], result)
		end	
	end
end
