#include "WkCocos/App42/Login.h"

namespace WkCocos
{
	namespace App42
	{
		Login::Login()
		{
			::App42::UserService *userService = ::App42::App42API::BuildUserService();
		}

		Login::~Login()
		{

		}

	}// namespace App42
} //namespace WkCocos
