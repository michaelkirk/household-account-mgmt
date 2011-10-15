class TestExceptionController < ApplicationController
  def test_exception
    raise Exception
  end
end
