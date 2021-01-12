# frozen_string_literal: true

# Honestly, I moved around the problem of having multiple attribute types
# by using arguments in the create actions and a simple :params in
# the update actions. It just feels more rails-y that way.
# I'm leaving this here in case I wante to refactor out the :params later.

# Note: You can't use complex types in attributes. They have to be scalar or input.
