# coding: utf-8
require 'spec_helper'
require './app'

describe "Problemモデルのテスト" do
  def app
    SQLApplication
  end

  it 'titleがnullだったら登録できない' do
    problem = Problem.create(id: 1,title: nil, statement: "test", answer: "test", level: 1)
    problem.save.should be false
  end

end
