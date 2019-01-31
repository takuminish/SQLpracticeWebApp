# coding: utf-8
require 'spec_helper'
require './app'

describe "Problemモデルのテスト" do
  def app
    SQLApplication
  end

  it 'statementがnullだったら登録できない' do
    problem = Problem.new(id: 1,title: "test", statement: nil, answer: "test", level: 1)
    expect(problem).not_to be_valid
  end

  it 'answerがnullだったら登録できない' do
    problem = Problem.new(id: 1,title: "test", statement: "test", answer: nil, level: 1)
    expect(problem).not_to be_valid
  end

  it 'levelがnullだったら登録できない' do
    problem = Problem.new(id: 1,title: "test", statement: "test", answer: "test", level: nil)
    expect(problem).not_to be_valid
  end

end
