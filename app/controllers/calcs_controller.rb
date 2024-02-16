class CalcsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_calculate_age, only: [:index,:new,:create]

  def index
  end

  def new
    @calc= Calc.new
  end

  def create
    @calc = Calc.new(calc_params)
    if @calc.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = Calc.find(params[:id])
    # グラフに渡すインスタンス変数
    # @calcs_data = Calc.all.pluck(:record, :total)
    @calcs_data = Calc.all.pluck(:id, :total)
  end

  private
  
  #   # @bmrを使ってcalculate_totalを呼び出す
  
  def calc_params
    plus = params[:calc][:plus].to_i
    minus = params[:calc][:minus].to_i
    calculated_total = calculate_total(@bmr, plus, minus)
    params.require(:calc).permit(:record, :plus, :minus).merge(user_id: current_user.id, total: calculated_total)
  end

  def set_user_and_calculate_age
    @user = current_user
    @age = calculate_age(@user.birthday) if @user.present?
    @bmr = calculate_bmr(@user.sex_id, @age, @user.height, @user.weight)
  end
  
  def calculate_age(birthday)
    today = Date.today
    age = today.year - birthday.year - ((today.month > birthday.month || (today.month == birthday.month && today.day >= birthday.day)) ? 0 : 1)
    age
  end

  def calculate_bmr(sex_id, age, height, weight)
    puts "sex_id: #{sex_id}, age: #{age}, height: #{height}, weight: #{weight}"
    # Mifflin-St Jeor 方程式に基づくBMRの計算
    # 男性の場合
    if sex_id == 2
      bmr = 13.397 * weight + 4.7899 * height - 5.677 * age + 88.362
    else
      # 女性の場合
      bmr = 9.247 * weight + 3.098 * height - 4.33 * age + 447.593
    end

    puts "calculated bmr: #{bmr}"
    bmr
  end

  def calculate_total(bmr, plus, minus)
    # ここでbmrやplus、minusに基づく計算を行う
    bmr + plus - minus
  end
end
