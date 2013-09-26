module Api
  module V1
    class NotesController < ApplicationController

      before_action :set_note, only: [:update, :destroy]

      def create
        @note = Note.new(note_params)
        @note.action = :added
        @note.user = current_user
        @note.subject = Organization.find params[:organization_id] if params[:organization_id].present?
        @note.subject = Person.find params[:person_id] if params[:person_id].present?
        @note.subject = Deal.find params[:deal_id] if params[:deal_id].present?
        @note.subject = User.find params[:user_id] if params[:user_id].present?
        if @note.save
          render json: @note
        else
          render json: @note, status: :unprocessable_entity
        end
      end

      def update
        if @note.update(note_params)
          render json: @note
        else
          render json: @note, status: :unprocessable_entity
        end
      end

      def destroy
        @note.destroy
        render json: @note
      end

      private

        def set_note
          @note = Note.find(params[:id])
        end

        def note_params
          params.require(:note).permit(:message)
        end

    end
  end
end