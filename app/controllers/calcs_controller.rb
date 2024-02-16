class CalcsController < ApplicationController
  before_action :set_user_and_calculate_age, only: [:new]

  def index
  end

  def new
  end

  def create
    @calc = Calc.new(calc_params)
    if @calc.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def calc_params
    params.require(:calc).permit(:record, :plus, :minus, :total).merge(user_id: current_user.id)
  end

  def set_user_and_calculate_age
    @user = current_user
    @age = calculate_age(@user.birthday) if @user.present?
    @bmr = calculate_bmr(@user.sex, @age, @user.height, @user.weight)
  end

  def calculate_age(birthday)
    today = Date.today
    age = today.year - birthday.year - ((today.month > birthday.month || (today.month == birthday.month && today.day >= birthday.day)) ? 0 : 1)
    age
  end

  def calculate_bmr(sex, age, height, weight)
    # Mifflin-St Jeor 方程式に基づくBMRの計算
    # 男性の場合
    if sex == 2
      bmr = 13.397 * weight + 4.7899 * height - 5.677 * @age + 88.362
    else
      # 女性の場合
      bmr = 9.247 * weight + 3.098 * height - 4.33 * @age + 447.593
    end
    bmr
  end

end
