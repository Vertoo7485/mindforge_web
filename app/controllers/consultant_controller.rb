class ConsultantController < ApplicationController
  def index
    @profile = current_user.financial_profile || current_user.build_financial_profile
    @recommendations = @profile.persisted? ? @profile.recommendations : []
  end

  def setup
    @profile = current_user.financial_profile || current_user.build_financial_profile
  end

  def save_profile
    @profile = current_user.financial_profile || current_user.build_financial_profile
    if @profile.update(profile_params)
      redirect_to consultant_path, notice: "Профиль сохранён. Смотрите рекомендации!"
    else
      render :setup, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:financial_profile).permit(
      :monthly_income, :monthly_expenses, :savings_goal, 
      :risk_level, :main_goal
    )
  end
end