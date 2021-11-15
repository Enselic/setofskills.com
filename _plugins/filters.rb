module SetOfSkillsFilters
    # Adds a 2x3 transparent png data uri to any img tag.
    # For use with img lazy-loading
    def add_noscript_for_lazyload_img(input)
    	# TODO: Fix this. rubular.com is useful help. Don't forget test cases
        #input.gsub /(<img[^>]+)data-original=([^\s]+)([^>]*/?>)/, "adf"
    end
    module_function :add_noscript_for_lazyload_img
end

# Don't register in unit tests
if Module::const_defined?(:Liquid)
	Liquid::Template.register_filter(SetOfSkillsFilters)
end
